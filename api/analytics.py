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


@router.get("/analytics/contracts")
def contract_analytics():
    try:
        df = pd.read_csv(DATASET_PATH)

        grouped = (
            df.groupby("Contract")["Churn"]
            .agg(
                total_customers="count",
                churned_customers=lambda x: (x == "Yes").sum(),
            )
            .reset_index()
        )

        grouped["churn_rate"] = (
            grouped["churned_customers"]
            / grouped["total_customers"]
            * 100
        ).round(2)

        return {
            "contract_analytics": grouped.to_dict(
                orient="records"
            )
        }

    except FileNotFoundError:
        raise HTTPException(
            status_code=500,
            detail="Customer churn dataset not found."
        )