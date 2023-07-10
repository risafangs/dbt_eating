from prefect import flow
from prefect_dbt.cli.commands import DbtCoreOperation
from prefect.deployments import Deployment
from prefect_snowflake import SnowflakeCredentials

# brought this in but not sure how to use it
#snowflake_credentials_block = SnowflakeCredentials.load("bdc-snowflake")

project_dir_path = "~/clients/internal/dbt_eating/"

@flow
def trigger_dbt_flow() -> str:
    result = DbtCoreOperation(
        commands=["dbt debug", "dbt build"],
        project_dir=project_dir_path,
        profiles_dir="." # copied my personal profile here
    ).run()
    return result

def deploy():
    deployment = Deployment.build_from_flow(
        flow=trigger_dbt_flow,
        name="dbt-build-deployment"
    )
    deployment.apply()

deploy()
