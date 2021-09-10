import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--env_path', type=str, required=True)
args = parser.parse_args()

file_path = "{}".format(args.env_path)
file_data = False

with open("{}/properties".format(file_path)) as file:
    lines = file.readlines()
    file_data = {item.split('=')[0].strip():item.split('=')[1].strip() for item in lines}

business_id = file_data['business_id']
business_name = file_data['business_name']
tablefile = "{}/{}".format(file_path, file_data['tablefile'])
tables_data = ''

with open(tablefile) as f:
    tables_data = f.readlines()

tables_data = [item.strip() for item in tables_data]
