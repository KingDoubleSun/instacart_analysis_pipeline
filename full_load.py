import redshift_connector
import configparser


def get_file_path(file, bucket_name):
    '''return S3 style file path'''
    return f"s3://{bucket_name}/{file}.csv"


# cresendential details
parser = configparser.ConfigParser()
parser.read("pipeline.conf")
hostname = parser.get("aws_redshift_creds", "host")
port = parser.get("aws_redshift_creds", "port")
username = parser.get("aws_redshift_creds", "user")
dbname = parser.get("aws_redshift_creds", "database")
password = parser.get("aws_redshift_creds", "password")
iam_role = parser.get("aws_redshift_creds", "iam_role")

account_id = parser.get("aws_boto_creds", "account_id")
bucket_name = parser.get("aws_boto_creds", "bucket_name")


# file names in the S3 bucket
file_names = ['orders', 'products', 'order_products', 'departments', 'aisles']
role_string = f"arn:aws:iam::{account_id}:role/{iam_role}"



# establish connection with AWS redshift
conn = redshift_connector.connect(
    host=hostname,
    database=dbname,
    port=int(port),
    user=username,
    password=password
)

# perform full load from S3 to redshift
with conn:
    with conn.cursor() as cursor:
        for file in file_names:
            sql = f"COPY raw_data.{file} " \
                  f"FROM '{get_file_path(file, bucket_name)}' " \
                  f"iam_role '{role_string}' " \
                  f"CSV IGNOREHEADER 1;"
            cursor.execute(sql)
    conn.commit()
