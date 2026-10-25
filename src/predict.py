from pathlib import Path
import joblib
import pandas as pd

MODEL_PATH = Path(__file__).resolve().parent.parent / "models" / "churn_pipeline.joblib"

model = joblib.load(MODEL_PATH)

def predict_churn(customer_data: dict) -> dict:
    customer_df = pd.DataFrame([customer_data])

    prediction = int(model.predict(customer_df)[0])
    probability = float(model.predict_proba(customer_df)[0][1])

    return {
        "prediction": "Churn" if prediction == 1 else "No Churn",
        "churn_probability": round(probability, 4)
    }