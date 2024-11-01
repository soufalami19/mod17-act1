FROM python:3.8-slim

WORKDIR /app

COPY dice_simulator.py /app
COPY requirements.txt /app

RUN pip install -r requirements.txt

CMD ["python", "dice_simulator.py"]
