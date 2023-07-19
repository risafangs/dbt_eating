# simpler example with two tasks and a flow
# just illustrative

import requests
from datetime import datetime
from prefect import flow, task

@task
# gets a cat fact and puts it in a json object
def get_cat_fact():
    fact = requests.get("https://catfact.ninja/fact")
    fact = fact.json()
    # only want the fact string
    return fact['fact']

@task
# returns current time on 24 hr clock
def get_current_time():
  current_time = datetime.now().strftime("%H:%M:%S")
  return current_time

@flow
def cat_time_flow():
    cat_fact = get_cat_fact()
    time = get_current_time()
    print("It's " + time + " your cat fact is: " + cat_fact)

cat_time_flow()
