# AWS Cloud Resume Portfolio 🚀

A full-stack, serverless portfolio website hosted entirely on AWS. This project demonstrates practical proficiency in cloud architecture, frontend-backend integration, security, and serverless development principles.

## 🏗️ Architecture Overview

The following diagram illustrates the serverless architecture constructed for this project. It separates the static frontend delivery from the dynamic backend logic used for the real-time visitor counter.

![AWS Cloud Resume Architecture](architecture-diagram/diagram_portfolio.png)

## 🌐 Live Demo
### [👉 View my Portfolio & Live Visitor Counter](https://d1fx4silgg9iud.cloudfront.net/)

---

## 🛠️ Tech Stack & Components

* **Frontend Hosting & Delivery:**
    * **Amazon S3:** Hosts the static website content (HTML, CSS, JavaScript) with high durability.
    * **Amazon CloudFront (CDN):** Ensures global low-latency content delivery and enforces secure HTTPS connections through SSL/TLS certificates.
* **Serverless Backend (Visitor Counter):**
    * **Amazon API Gateway (HTTP API):** Acts as a secure entry point, routing requests from the frontend to the backend logic.
    * **AWS Lambda (Python 3.12):** A serverless function that handles the logic of incrementing and retrieving the visitor count.
    * **Amazon DynamoDB:** A fully managed NoSQL database used for high-performance data storage and atomic updates.

---

## 🚀 Key Features

* **Serverless Architecture:** Completely managed infrastructure with zero server maintenance and automatic scaling.
* **Real-time Visitor Counter:** Dynamic integration of database and backend logic into a static frontend.
* **Security First:** Implementation of IAM least-privilege policies and secure data transmission via CloudFront.
* **Performance Optimized:** Global edge caching ensures the portfolio loads instantly from anywhere in the world.

---

## 📂 Project Structure

```bash
aws-cloud-resume-portfolio/
├── architecture-diagram/
│   └── diagram.png       # Architecture diagram
├── backend/
│   └── lambda_function.py # Python code for AWS Lambda
├── frontend/
│   └── index.html        # Website structure, CSS, and JS API fetch logic
└── README.md             # Project documentation
```

## 🎓 Professional Context

This project was designed and built to showcase the practical application of my skills as an AWS Certified Solutions Architect – Associate. It serves as a production-ready demonstration of my ability to design, deploy, and troubleshoot complex serverless architectures within the AWS ecosystem. By bridging the gap between theoretical knowledge and hands-on implementation, this portfolio reflects my commitment to building secure, scalable, and efficient cloud solutions.
