from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import boto3
import os

app = FastAPI()

# Ρύθμιση CORS: Το FastAPI το διαχειρίζεται αυτόματα και πιο καθαρά από τη Lambda
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Στην παραγωγή θα βάλουμε το domain μας
    allow_methods=["*"],
    allow_headers=["*"],
)

# Σύνδεση με τη DynamoDB
# Το EKS θα χρησιμοποιεί IAM Roles για να δώσει πρόσβαση χωρίς κλειδιά στον κώδικα
dynamodb = boto3.resource('dynamodb', region_name='us-east-1') # Βαζουμε το region μας
table = dynamodb.Table('thanos-portfolio-stats')

@app.get("/")
def read_root():
    return {"status": "Cloud Resume API is running on Kubernetes!"}

@app.get("/visit")
def increment_counter():
    response = table.update_item(
        Key={'id': 'visitors'},
        UpdateExpression='ADD #c :val',
        ExpressionAttributeNames={'#c': 'count'},
        ExpressionAttributeValues={':val': 1},
        ReturnValues='UPDATED_NEW'
    )
    
    visitor_count = response['Attributes']['count']
    return {"count": int(visitor_count)}

# Για τοπικό έλεγχο
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8080)