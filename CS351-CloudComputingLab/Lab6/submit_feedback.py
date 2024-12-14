# File to handle the form submission and insert feedback into the RDS database.
import pymysql
from flask import Flask, request

# Flask application
app = Flask(__name__)

# MySQL connection details (use the RDS endpoint)
connection = pymysql.connect(
    host='rds-assignment6on.cdmww2o4cdu9.ap-south-1.rds.amazonaws.com',
    user='admin',
    password='HelloWorld123',
    database='feedbackDB6'
)

# Define the table schema (only run this once to create the table)
with connection.cursor() as cursor:
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS feedback (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100),
            email VARCHAR(100),
            comment TEXT NOT NULL
        );
    """)
    connection.commit()

# Route to handle form submissions
@app.route('/submit_feedback', methods=['POST'])
def submit_feedback():
    name = request.form['name']
    email = request.form['email']
    comment = request.form['comment']
    # Insert feedback into the database
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO feedback (name, email, comment) VALUES (%s, %s, %s)",
                       (name, email, comment))
        connection.commit()
    return "Feedback submitted successfully!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
