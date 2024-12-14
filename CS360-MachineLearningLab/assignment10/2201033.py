import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn.preprocessing import LabelEncoder


# Load the dataset
def load_data():
    # Replace with the path to your dataset or load your dataset here
    # Example: df = pd.read_csv('path_to_your_data.csv')
    # For now, using a dummy DataFrame to represent your data
    data = {
        'gender': ['Male', 'Female', 'Female', 'Male', 'Female'],
        'senior_citizen': [0, 1, 1, 0, 0],
        'partner': ['Yes', 'No', 'Yes', 'No', 'Yes'],
        'dependents': ['No', 'No', 'Yes', 'No', 'Yes'],
        'tenure': [1, 34, 45, 2, 6],
        'phone_service': ['Yes', 'Yes', 'Yes', 'No', 'Yes'],
        'multiple_lines': ['No', 'Yes', 'No', 'No', 'No'],
        'internet_service': ['DSL', 'Fiber optic', 'DSL', 'No', 'Fiber optic'],
        'contract': ['Month-to-month', 'One year', 'Two year', 'Month-to-month', 'One year'],
        'payment_method': ['Electronic check', 'Mailed check', 'Credit card', 'Bank transfer', 'Electronic check'],
        'churn': ['Yes', 'No', 'Yes', 'No', 'Yes']
    }

    df = pd.DataFrame(data)
    return df


# Preprocess the data (encode categorical features)
def preprocess_data(df):
    # Encode categorical columns using LabelEncoder
    le = LabelEncoder()
    categorical_columns = ['gender', 'partner', 'dependents', 'phone_service', 'multiple_lines', 'internet_service',
                           'contract', 'payment_method', 'churn']

    for col in categorical_columns:
        df[col] = le.fit_transform(df[col])

    return df


# Split the data into training and test sets
def split_data(df):
    X = df.drop('churn', axis=1)  # Features
    y = df['churn']  # Target variable (churn)

    # Split into 80% training and 20% testing data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    return X_train, X_test, y_train, y_test


# Implementing Naive Bayes Classifier
class NaiveBayes:
    def fit(self, X_train, y_train):
        # Calculate prior probabilities
        self.classes = np.unique(y_train)
        self.prior = {cls: np.mean(y_train == cls) for cls in self.classes}

        # Calculate likelihoods (conditional probabilities)
        self.likelihood = {}
        for cls in self.classes:
            X_cls = X_train[y_train == cls]
            self.likelihood[cls] = {}
            for col in X_train.columns:
                feature_values = X_cls[col]
                # Mean and variance of the feature for this class
                self.likelihood[cls][col] = (feature_values.mean(), feature_values.std())

    def predict(self, X_test):
        predictions = []
        for i in range(len(X_test)):
            posteriors = {}
            for cls in self.classes:
                prior = np.log(self.prior[cls])  # Log of prior probability
                likelihood = 0
                for col in X_test.columns:
                    mean, std = self.likelihood[cls][col]
                    # Gaussian likelihood
                    likelihood += np.log(self.gaussian_pdf(X_test[col][i], mean, std))
                posteriors[cls] = prior + likelihood
            predictions.append(max(posteriors, key=posteriors.get))
        return np.array(predictions)

    def gaussian_pdf(self, x, mean, std):
        # Gaussian probability density function
        return (1 / (np.sqrt(2 * np.pi) * std)) * np.exp(-(x - mean) ** 2 / (2 * std ** 2))


# Main function to run the Naive Bayes classifier and evaluate the model
def main():
    # Step 1: Load and preprocess the dataset
    df = load_data()
    df = preprocess_data(df)

    # Step 2: Split the dataset into training and testing sets
    X_train, X_test, y_train, y_test = split_data(df)

    # Step 3: Train the Naive Bayes classifier
    nb = NaiveBayes()
    nb.fit(X_train, y_train)

    # Step 4: Make predictions on the test set
    y_pred = nb.predict(X_test)

    # Step 5: Evaluate the model
    accuracy = accuracy_score(y_test, y_pred)
    precision = precision_score(y_test, y_pred)
    recall = recall_score(y_test, y_pred)
    f1 = f1_score(y_test, y_pred)

    # Display evaluation metrics
    print(f"Accuracy: {accuracy * 100:.2f}%")
    print(f"Precision: {precision * 100:.2f}%")
    print(f"Recall: {recall * 100:.2f}%")
    print(f"F1 Score: {f1 * 100:.2f}%")


if __name__ == "__main__":
    main()
