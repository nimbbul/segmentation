FROM anibali/pytorch:1.8.1-cuda11.1-ubuntu20.04

# Set up time zone.
ENV TZ=UTC
RUN sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN sudo apt-get update \
 && sudo apt-get install -y libgl1-mesa-glx libgtk2.0-0 libsm6 libxext6 \
 && sudo rm -rf /var/lib/apt/lists/*

# Install requirements
COPY requirements.txt .
RUN python -m pip install --upgrade pip && pip install --no-cache -r requirements.txt

# Copy contents
COPY . /app

RUN pip install -U --no-cache torch torchvision --default-timeout=100
# Change workdir
WORKDIR /app
RUN sudo chmod -R ugo+rwx /app

ENTRYPOINT ["python"]
CMD ["example_app.py"]