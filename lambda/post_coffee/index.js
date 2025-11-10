const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  try {
    const item = JSON.parse(event.body);
    await dynamo.send(new PutCommand({
      TableName: "coffee_inventory",
      Item: item
    }));

    return {
      statusCode: 201,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST,GET,PUT,DELETE"
      },
      body: JSON.stringify({ message: "Coffee added", item }),
    };
  } catch (err) {
    console.error("POST error:", err);
    return {
      statusCode: 500,
      headers: { "Access-Control-Allow-Origin": "*" },
      body: JSON.stringify({ message: "Internal server error", error: err.message }),
    };
  }
};
