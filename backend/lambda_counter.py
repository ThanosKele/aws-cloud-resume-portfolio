import json
import boto3

# Σύνδεση με τη DynamoDB
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('thanos-portfolio-stats')

def lambda_handler(event, context):
    # Ενημέρωση του count (προσθέτει +1 στο υπάρχον count)
    response = table.update_item(
        Key={'id': 'visitors'},
        UpdateExpression='ADD #c :val',
        ExpressionAttributeNames={'#c': 'count'},
        ExpressionAttributeValues={':val': 1},
        ReturnValues='UPDATED_NEW'
    )
    
    # Παίρνουμε το νέο νούμερο
    visitor_count = response['Attributes']['count']

    # Επιστροφή του αποτελέσματος με CORS headers (για να μπορεί να το διαβάσει ο browser)
    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*', # Επιτρέπει σε κάθε site να καλεί το API
            'Access-Control-Allow-Methods': 'GET,OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'
        },
        'body': json.dumps({'count': int(visitor_count)})
    }