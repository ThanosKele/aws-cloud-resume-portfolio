FROM python:3.9-slim

WORKDIR /app

# Αντιγραφή και εγκατάσταση dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Αντιγραφή του κώδικα
COPY main.py .

# Εκτέλεση του API με το Uvicorn
EXPOSE 8080
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]