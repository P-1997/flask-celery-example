
FROM python:3.7-alpine

RUN mkdir /app
WORKDIR /app

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

# Expose Flask default port
EXPOSE 5000

# Command to run your application
CMD ["python3", "run.py"]
