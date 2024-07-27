"use client";

// This is a simple mock authentication.
// In a real application, you'd want to use a proper authentication service.

interface User {
  email: string;
  password: string;
}

const users: User[] = [{ email: "user@example.com", password: "password123" }];

export async function authenticate(
  email: string,
  password: string
): Promise<boolean> {
  // Simulate network delay
  await new Promise((resolve) => setTimeout(resolve, 300));

  const user = users.find((u) => u.email === email && u.password === password);
  return !!user;
}
