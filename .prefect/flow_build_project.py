from prefect import flow
from prefect_dbt.cli.commands import DbtCoreOperation

@flow
def trigger_dbt_flow() -> str:
    result = DbtCoreOperation(
        commands=["dbt debug", "dbt run"],
        project_dir="../",
        profiles_dir="." # copied my personal profile here
    ).run()
    return result

trigger_dbt_flow()

