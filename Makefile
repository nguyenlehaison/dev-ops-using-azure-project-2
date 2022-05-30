install:
	python3.7 -m pip install --upgrade pip &&\
		python3.7 -m pip install -r requirements.txt

test:
	python3.7 -m pytest -vv test_hello.py

all: install lint test