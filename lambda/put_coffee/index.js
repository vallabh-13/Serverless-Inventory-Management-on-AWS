const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, UpdateCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  try {
    const coffee_name = event.pathParameters.coffee_name;
    const updates = JSON.parse(event.body);

    // Remove the partition key from updates (can't update partition keys in DynamoDB)
    delete updates.coffee_name;

    // Check if there are any attributes left to update
    if (Object.keys(updates).length === 0) {
      return {
        statusCode: 400,
        headers: { "Access-Control-Allow-Origin": "*" },
        body: JSON.stringify({ message: "No attributes to update" }),
      };
    }

    const updateExpression = [];
    const expressionAttributeNames = {};
    const expressionAttributeValues = {};

    for (const key in updates) {
      // Use ExpressionAttributeNames to handle reserved words
      updateExpression.push(`#${key} = :${key}`);
      expressionAttributeNames[`#${key}`] = key;
      expressionAttributeValues[`:${key}`] = updates[key];
    }

    await dynamo.send(new UpdateCommand({
      TableName: "coffee_inventory",
      Key: { coffee_name },
      UpdateExpression: `SET ${updateExpression.join(", ")}`,
      ExpressionAttributeNames: expressionAttributeNames,
      ExpressionAttributeValues: expressionAttributeValues
    }));

    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST,GET,PUT,DELETE"
      },
      body: JSON.stringify({ message: "Coffee updated", coffee_name }),
    };
  } catch (err) {
    console.error("PUT error:", err);
    return {
      statusCode: 500,
      headers: { "Access-Control-Allow-Origin": "*" },
      body: JSON.stringify({ message: "Internal server error", error: err.message }),
    };
  }
};
