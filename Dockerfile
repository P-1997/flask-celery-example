FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc libssl-dev libffi-dev curl netcat-openbsd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy requirements first and downgrade pip to avoid Celery metadata error
COPY requirements.txt .
RUN pip install --no-cache-dir "pip<24.1" \
 && pip install --no-cache-dir -r requirements.txt


# Copy rest of the app
COPY . .

# Expose Flask port
EXPOSE 5000

# Default command (overridden in docker-compose for Celery worker)
CMD ["python", "app.py"]
