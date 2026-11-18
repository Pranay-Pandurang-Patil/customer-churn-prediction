import os

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

from src.predict import predict_churn
from api.analytics import router as analytics_router
from api.insights import router as insights_router


app = FastAPI(
    title="Customer Churn Prediction API",
    description="Predict customer churn using machine learning.",
    version="1.0.0"
)


# CORS CONFIGURATION
allowed_origins = os.getenv("FRONTEND_ORIGIN", "")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        origin.strip()
        for origin in allowed_origins.split(",")
        if origin.strip()
    ],
    allow_origin_regex=r"http://(localhost|127\.0\.0\.1)(:\d+)?",
    allow_credentials=False,
    allow_methods=["GET", "POST"],
    allow_headers=["Content-Type"],
)


# REGISTER ROUTERS
app.include_router(analytics_router)
app.include_router(insights_router)


# CUSTOMER INPUT VALIDATION
class CustomerData(BaseModel):
    gender: str
    SeniorCitizen: int = Field(ge=0, le=1)
    Partner: str
    Dependents: str
    tenure: int = Field(ge=0, le=72)
    PhoneService: str
    MultipleLines: str
    InternetService: str
    OnlineSecurity: str
    OnlineBackup: str
    DeviceProtection: str
    TechSupport: str
    StreamingTV: str
    StreamingMovies: str
    Contract: str
    PaperlessBilling: str
    PaymentMethod: str
    MonthlyCharges: float = Field(ge=0)
    TotalCharges: float | None = Field(default=None, ge=0)


# HOME ENDPOINT
@app.get("/")
def home():
    return {
        "message": "Customer Churn Prediction API is running"
    }


# PREDICTION ENDPOINT
@app.post("/predict")
def predict(customer: CustomerData):
    try:
        return predict_churn(customer.model_dump())

    except Exception as exc:
        raise HTTPException(
            status_code=500,
            detail="Prediction failed. Check the server logs."
        ) from exc


# HEALTH CHECK ENDPOINT
@app.get("/health")
def health_check():
    return {
        "status": "healthy",
        "service": "Customer Churn Prediction API"
    }