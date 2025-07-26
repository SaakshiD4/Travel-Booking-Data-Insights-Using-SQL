<h1 style="color: teal;">💼 Travel Booking Data Insights Using SQL</h1>

## 1. Segment Activity
What I Did: Counted bookings grouped by segment.

Insights: Segment s1 had most bookings; others less active.

Learned: Simple grouping helps spot high-engagement user groups.

## 2. Inactive Users
What I Did: Used LEFT JOIN to find users with no bookings.

Insights: Found users who never booked (e.g., u3).

Learned: LEFT JOIN + IS NULL is a solid way to find gaps.

## 3. Users Using Multiple Services
What I Did: Counted distinct services per user.

Insights: Only u1 used both hotel and flight.

Learned: HAVING COUNT(DISTINCT ...) > 1 helps find variety-seekers.

## 4. Top Bookers
What I Did: Ranked users by booking count.

Insights: u1 was the most active user.

Learned: Use ORDER BY with LIMIT to find top performers.

## 5. Month-wise Trends
What I Did: Filtered bookings for April 2022.
Insights: All bookings were in April—no long-term users.
Learned: EXTRACT(MONTH/YEAR) makes time analysis simple.

## 6. Booking Across Months
What I Did: Checked how many months each user booked in.

Insights: No users booked in multiple months.

Learned: GROUP BY user, month + HAVING COUNT(DISTINCT) helps spot repeaters.

## 7. First Service Used
What I Did: Used RANK() to find each user’s first booking.

Insights: u1 started with hotel; tracked first usage.

Learned: Ranking over dates gives first-touch info.

## 8. Segment + Service Combo
What I Did: Grouped by segment and service type.

Insights: s1 showed the most variety; others limited.

Learned: Multi-column GROUP BY reveals behavior patterns across dimensions.


This project helped me analyze user behavior in a travel booking platform using SQL. I explored how different user segments interact with services like Flights and Hotels, identified inactive users, first-time bookings, and booking trends.

It gave me a better understanding of using JOINs, GROUP BY, window functions, and date functions to extract actionable business insights.
