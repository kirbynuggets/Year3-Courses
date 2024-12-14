from pyspark.sql import SparkSession
from pyspark.ml.feature import VectorAssembler, StandardScaler
from pyspark.ml.clustering import KMeans
from pyspark.sql.functions import col, desc, lower, trim
from pyspark.sql.types import IntegerType

# Initialize Spark session
spark = SparkSession.builder \
    .appName("Adult Dataset Analysis") \
    .getOrCreate()

# Load the dataset (assuming it's in CSV format)
data = spark.read.csv("adult.data", header=False, inferSchema=True)

# Rename columns for better readability
columns = [
    "age", "workclass", "fnlwgt", "education", "education_num",
    "marital_status", "occupation", "relationship", "race",
    "sex", "capital_gain", "capital_loss", "hours_per_week",
    "native_country", "income"
]
for i, col_name in enumerate(columns):
    data = data.withColumnRenamed(f"_c{i}", col_name)

# Clean and cast the data types
data = data.select(
    col("age").cast(IntegerType()).alias("age"),
    col("workclass"),
    col("fnlwgt").cast(IntegerType()),
    col("education"),
    col("education_num").cast(IntegerType()).alias("education_num"),
    col("marital_status"),
    col("occupation"),
    col("relationship"),
    col("race"),
    col("sex"),
    col("capital_gain").cast(IntegerType()),
    col("capital_loss").cast(IntegerType()),
    col("hours_per_week").cast(IntegerType()).alias("hours_per_week"),
    col("native_country"),
    col("income")
)


def perform_clustering(data):
    # Prepare features for clustering
    assembler = VectorAssembler(
        inputCols=["age", "education_num", "hours_per_week"],
        outputCol="features"
    )

    # Standardize the features
    data_assembled = assembler.transform(data)
    scaler = StandardScaler(
        inputCol="features",
        outputCol="scaled_features",
        withStd=True,
        withMean=True
    )

    scaler_model = scaler.fit(data_assembled)
    data_scaled = scaler_model.transform(data_assembled)

    # Perform K-means clustering
    kmeans = KMeans(k=5, featuresCol="scaled_features")
    model = kmeans.fit(data_scaled)

    # Add cluster predictions to the dataframe
    return model.transform(data_scaled)


def get_top_country_except_usa(data):
    return data.filter(
        (~trim(lower(col("native_country"))).isin(["united-states", "?"])) &
        (col("age") >= 18)
    ) \
        .groupBy("native_country") \
        .count() \
        .orderBy(desc("count")) \
        .first()


def get_masters_tech_support_count(data):
    return data.filter(
        (trim(lower(col("education"))).isin(["masters", "doctorate"])) &
        (trim(lower(col("occupation"))) == "tech-support")
    ).count()


def get_unmarried_male_local_govt_count(data):
    return data.filter(
        (trim(lower(col("sex"))) == "male") &
        (trim(lower(col("workclass"))) == "local-gov") &
        (trim(lower(col("marital_status"))).isin(["never-married"]))
    ).count()


def main():
    # Perform clustering
    clustered_data = perform_clustering(data)

    # Execute analysis
    top_country = get_top_country_except_usa(data)
    print(f"\nCountry with highest number of adults (except USA): {top_country['native_country']} "
          f"(Count: {top_country['count']})")

    masters_tech = get_masters_tech_support_count(data)
    print(f"\nNumber of people with at least Masters in Tech-support: {masters_tech}")

    unmarried_male_local = get_unmarried_male_local_govt_count(data)
    print(f"\nNumber of unmarried males in Local government: {unmarried_male_local}")


if __name__ == "__main__":
    main()
    spark.stop()