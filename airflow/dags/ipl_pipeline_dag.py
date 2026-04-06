from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta
import subprocess
import sys

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "email_on_failure": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

def run_ingestion():
    result = subprocess.run(
        [sys.executable, "/opt/airflow/ingestion/load_to_bq.py"],
        capture_output=True,
        text=True
    )
    print(result.stdout)
    if result.returncode != 0:
        raise Exception(f"Ingestion failed: {result.stderr}")

with DAG(
    dag_id="ipl_elt_pipeline",
    default_args=default_args,
    description="Daily IPL ELT pipeline: ingest → dbt transform",
    schedule_interval="0 6 * * *",
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["ipl", "portfolio"],
) as dag:

    ingest_task = PythonOperator(
        task_id="ingest_raw_data",
        python_callable=run_ingestion,
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="cd /opt/airflow/dbt_ipl/dbt_ipl && dbt run --profiles-dir . --no-version-check",
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="cd /opt/airflow/dbt_ipl/dbt_ipl && dbt test --profiles-dir . --no-version-check",
    )

    ingest_task >> dbt_run >> dbt_test