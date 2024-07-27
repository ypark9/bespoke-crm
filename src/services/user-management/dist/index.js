"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = void 0;
const aws_sdk_1 = require("aws-sdk");
const uuid_1 = require("uuid");
const dynamoDB = new aws_sdk_1.DynamoDB.DocumentClient();
const TABLE_NAME = process.env.USER_TABLE_NAME || "Users";
const handler = async (event) => {
    var _a, _b, _c;
    try {
        switch (event.httpMethod) {
            case "POST":
                return await createUser(JSON.parse(event.body || "{}"));
            case "GET":
                return ((_a = event.pathParameters) === null || _a === void 0 ? void 0 : _a.id)
                    ? await getUser(event.pathParameters.id)
                    : await listUsers();
            case "PUT":
                return await updateUser((_b = event.pathParameters) === null || _b === void 0 ? void 0 : _b.id, JSON.parse(event.body || "{}"));
            case "DELETE":
                return await deleteUser((_c = event.pathParameters) === null || _c === void 0 ? void 0 : _c.id);
            default:
                return {
                    statusCode: 400,
                    body: JSON.stringify({ message: "Unsupported HTTP method" }),
                };
        }
    }
    catch (error) {
        console.error(error);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: "Internal server error" }),
        };
    }
};
exports.handler = handler;
async function createUser(userData) {
    const user = {
        id: (0, uuid_1.v4)(),
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
async function getUser(id) {
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
async function listUsers() {
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
async function updateUser(id, userData) {
    if (!id) {
        return {
            statusCode: 400,
            body: JSON.stringify({ message: "User ID is required" }),
        };
    }
    const updateExpression = "set " +
        Object.keys(userData)
            .map((key) => `#${key} = :${key}`)
            .join(", ") +
        ", updatedAt = :updatedAt";
    const expressionAttributeNames = Object.keys(userData).reduce((acc, key) => ({ ...acc, [`#${key}`]: key }), {});
    const expressionAttributeValues = Object.keys(userData).reduce((acc, key) => ({ ...acc, [`:${key}`]: userData[key] }), {
        ":updatedAt": new Date().toISOString(),
    });
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
async function deleteUser(id) {
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
