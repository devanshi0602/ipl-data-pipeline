import pandas as pd
from google.cloud import bigquery
from google.oauth2 import service_account
import os

# Config
PROJECT_ID = "ipl-pipeline"
DATASET = "raw"
KEY_PATH = "./credentials/gcp-key.json"
DATA_PATH = "./data/raw"

credentials = service_account.Credentials.from_service_account_file(KEY_PATH)
client = bigquery.Client(project=PROJECT_ID, credentials=credentials)

def load_csv_to_bq(filename: str, table_name: str):
    filepath = os.path.join(DATA_PATH, filename)
    df = pd.read_csv(filepath)

    df.columns = df.columns.str.lower().str.replace(" ", "_").str.replace("/", "_")

    table_id = f"{PROJECT_ID}.{DATASET}.{table_name}"

    job_config = bigquery.LoadJobConfig(
        write_disposition="WRITE_TRUNCATE",
        autodetect=True,
    )

    job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
    job.result()

    table = client.get_table(table_id)
    print(f"Loaded {table.num_rows} rows into {table_id}")

if __name__ == "__main__":
    load_csv_to_bq("matches.csv", "matches")
    load_csv_to_bq("deliveries.csv", "deliveries")
    print("Ingestion complete!")