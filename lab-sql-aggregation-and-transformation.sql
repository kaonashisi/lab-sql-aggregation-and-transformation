use sakila;

/*
Challenge 1

    You need to use SQL built-in functions to gain insights relating to the duration of movies:
        1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
        1.2. Express the average movie duration in hours and minutes. Don't use decimals.
            Hint: Look for floor and round functions.
*/
select min(length) as min_duration, max(length) as max_duration from film;
select floor(avg(length) / 60 ) as hour, floor(avg(length) % 60)  as minute from film ;
/*
    You need to gain insights related to rental dates:
        2.1 Calculate the number of days that the company has been operating.
            Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
        2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
        2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
            Hint: use a conditional expression.

    You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
        Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
        Hint: Look for the IFNULL() function.

*/
select datediff(max(rental_date), min(rental_date)) as days_been_operating from rental;
select dayname(rental_date) AS weekday, monthname(rental_date) AS month
from rental limit 20;

/*
Challenge 2

    Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
        1.1 The total number of films that have been released.
        1.2 The number of films for each rating.
        1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
   
*/

select count(*) as number_film_released
from film
where release_year is not null;

select rating, count(title) as number_of_films
from film
group by rating;

select rating, count(title) as number_of_films
from film
group by rating
order by number_of_films desc;

/*

 Using the film table, determine:
        2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
        2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
    Bonus: determine which last names are not repeated in the table actor.
*/

select rating, round(avg(length),2) as mean_film_duration
from film
group by rating
order by mean_film_duration desc;

select rating, round(avg(length),2) as mean_film_duration
from film
group by rating
having mean_film_duration > 120;