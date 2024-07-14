import { APIGatewayProxyHandler, APIGatewayProxyResult } from "aws-lambda";
import { DynamoDB } from "aws-sdk";
import { v4 as uuidv4 } from "uuid";

const dynamoDB = new DynamoDB.DocumentClient();
const TABLE_NAME = process.env.USER_TABLE_NAME || "Users";

interface User {
  id: string;
  username: string;
  email: string;
  createdAt: string;
  updatedAt: string;
}

export const handler: APIGatewayProxyHandler = async (
  event
): Promise<APIGatewayProxyResult> => {
  try {
    switch (event.httpMethod) {
      case "POST":
        return await createUser(JSON.parse(event.body || "{}"));
      case "GET":
        return event.pathParameters?.id
          ? await getUser(event.pathParameters.id)
          : await listUsers();
      case "PUT":
        return await updateUser(
          event.pathParameters?.id,
          JSON.parse(event.body || "{}")
        );
      case "DELETE":
        return await deleteUser(event.pathParameters?.id);
      default:
        return {
          statusCode: 400,
          body: JSON.stringify({ message: "Unsupported HTTP method" }),
        };
    }
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      body: JSON.stringify({ message: "Internal server error" }),
    };
  }
};

async function createUser(
  userData: Partial<User>
): Promise<APIGatewayProxyResult> {
  const user: User = {
    id: uuidv4(),
    username: userData.username || "",
    email: userData.email || "",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  };

  await dynamoDB
    .put({
      TableName: TABLE_NAME,
      Item: user,
    })
    .promise();

  return {
    statusCode: 201,
    body: JSON.stringify(user),
  };
}

async function getUser(id: string): Promise<APIGatewayProxyResult> {
  const result = await dynamoDB
    .get({
      TableName: TABLE_NAME,
      Key: { id },
    })
    .promise();

  if (!result.Item) {
    return {
      statusCode: 404,
      body: JSON.stringify({ message: "User not found" }),
    };
  }

  return {
    statusCode: 200,
    body: JSON.stringify(result.Item),
  };
}

async function listUsers(): Promise<APIGatewayProxyResult> {
  const result = await dynamoDB
    .scan({
      TableName: TABLE_NAME,
    })
    .promise();

  return {
    statusCode: 200,
    body: JSON.stringify(result.Items),
  };
}

async function updateUser(
  id: string | undefined,
  userData: Partial<User>
): Promise<APIGatewayProxyResult> {
  if (!id) {
    return {
      statusCode: 400,
      body: JSON.stringify({ message: "User ID is required" }),
    };
  }

  const updateExpression =
    "set " +
    Object.keys(userData)
      .map((key) => `#${key} = :${key}`)
      .join(", ") +
    ", updatedAt = :updatedAt";
  const expressionAttributeNames = Object.keys(userData).reduce(
    (acc, key) => ({ ...acc, [`#${key}`]: key }),
    {}
  );
  const expressionAttributeValues = Object.keys(userData).reduce(
    (acc, key) => ({ ...acc, [`:${key}`]: userData[key as keyof User] }),
    {
      ":updatedAt": new Date().toISOString(),
    }
  );

  await dynamoDB
    .update({
      TableName: TABLE_NAME,
      Key: { id },
      UpdateExpression: updateExpression,
      ExpressionAttributeNames: expressionAttributeNames,
      ExpressionAttributeValues: expressionAttributeValues,
    })
    .promise();

  return {
    statusCode: 200,
    body: JSON.stringify({ message: "User updated successfully" }),
  };
}

async function deleteUser(
  id: string | undefined
): Promise<APIGatewayProxyResult> {
  if (!id) {
    return {
      statusCode: 400,
      body: JSON.stringify({ message: "User ID is required" }),
    };
  }

  await dynamoDB
    .delete({
      TableName: TABLE_NAME,
      Key: { id },
    })
    .promise();

  return {
    statusCode: 200,
    body: JSON.stringify({ message: "User deleted successfully" }),
  };
}
