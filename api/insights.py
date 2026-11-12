from pathlib import Path

import pandas as pd
from fastapi import APIRouter, HTTPException

router = APIRouter()

DATASET_PATH = (
    Path(__file__).resolve().parent.parent
    / "data"
    / "raw"
    / "Telco-Customer-Churn.csv"
)


def calculate_churn_insights(df, column, dimension):
    grouped = (
        df.groupby(column, dropna=False)
        .agg(
            total_customers=("Churn", "size"),
            churned_customers=(
                "Churn",
                lambda values: (values == "Yes").sum(),
            ),
        )
        .reset_index()
    )

    grouped["churn_rate"] = (
        grouped["churned_customers"]
        / grouped["total_customers"]
        * 100
    ).round(2)

    grouped = grouped.sort_values(
        by="churn_rate",
        ascending=False,
    )

    return [
        {
            "dimension": dimension,
            "segment": str(row[column]),
            "total_customers": int(row["total_customers"]),
            "churned_customers": int(row["churned_customers"]),
            "churn_rate": float(row["churn_rate"]),
        }
        for _, row in grouped.iterrows()
    ]


@router.get("/analytics/retention-insights")
def retention_insights():
    try:
        df = pd.read_csv(DATASET_PATH)

        df["tenure_group"] = pd.cut(
            df["tenure"],
            bins=[-1, 12, 24, 48, 72],
            labels=[
                "0-12 Months",
                "13-24 Months",
                "25-48 Months",
                "49-72 Months",
            ],
        )

        insights = []

        insights.extend(
            calculate_churn_insights(
                df,
                "Contract",
                "Contract",
            )
        )

        insights.extend(
            calculate_churn_insights(
                df,
                "InternetService",
                "Internet Service",
            )
        )

        insights.extend(
            calculate_churn_insights(
                df,
                "tenure_group",
                "Customer Tenure",
            )
        )

        return {
            "retention_insights": insights
        }

    except FileNotFoundError:
        raise HTTPException(
            status_code=500,
            detail="Customer churn dataset not found.",
        )

    except Exception as exc:
        raise HTTPException(
            status_code=500,
            detail="Unable to generate retention insights.",
        ) from exc