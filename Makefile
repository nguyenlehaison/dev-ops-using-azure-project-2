install:
	python3.7 -m pip install --upgrade pip &&\
		python3.7 -m pip install -r requirements.txt

test:
	python -m pytest -vv test_hello.py

lint:
	pylint hello.py

all: install lint test