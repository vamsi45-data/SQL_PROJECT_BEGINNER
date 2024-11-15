use mavenmovies;
select * from staff;
/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 

select first_name, last_name, email, store_id
from staff;



/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 
select store_id, count(inventory_id) as no_of_inventory_items
from inventory
group by store_id;



/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/
select store_id,
	count(case when active = 1 then 1 else null  end
) as no_of_stores_active
from customer
group by store_id;


/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/
select count(email)
from customer;


/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/
SELECT 
	store_id, 
    COUNT(DISTINCT film_id) AS unique_films
FROM inventory
GROUP BY 
	store_id;

/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/
select min(replacement_cost) as least_expensive,
max(replacement_cost)as most_expensive,
avg(replacement_cost) as avg_cost
from film;



/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/
select 
max(amount) as max_amount,
avg(amount) as avg_payment
 from payment;




/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

select customer_id, count(rental_id) as no_of_rentals
from rental
group by customer_id
order by no_of_rentals desc ;

-- Part-2

/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

select 
	staff.first_name AS manager_first_name, 
    staff.last_name AS manager_last_name,
    s.store_id, a.address, a.district, c.city ,co.country
from staff 
join 
store s
on s.manager_staff_id=staff.staff_id
join address a 
on s.address_id=a.address_id
join city c
on a.city_id=c.city_id
join country co
on c.country_id=co.country_id;


	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/
select i.store_id, i.inventory_id, f.title, f.rating, f.rental_rate, f.replacement_cost
 from Inventory i
left join film f
on i.film_id =f.film_id;






/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

select i.store_id, count(inventory_id) as no_of_Items, f.rating
 from Inventory i
left join film f
on i.film_id =f.film_id
group by  i.store_id, f.rating 
order by i.store_id, no_of_Items desc;





/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

SELECT 
  inventory.store_id,
  category.name, 
  COUNT(film.title) AS no_of_films,
  AVG(film.replacement_cost) AS avg_replacement_cost, 
  SUM(film.replacement_cost) AS total_replacement_cost
FROM 
  film 
JOIN 
  film_category ON film.film_id = film_category.film_id
JOIN 
  inventory ON inventory.film_id = film.film_id
JOIN 
  category ON category.category_id = film_category.category_id
GROUP BY 
  inventory.store_id, category.category_id
ORDER BY 
  inventory.store_id, film_category.category_id
LIMIT 0, 1000;


/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

select first_name,last_name, store_id, active, address, city, country
from customer c
join address a  on c.address_id =a.address_id
join city
on a.city_id=city.city_id
join country on
city.country_id=country.country_id;





/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/


select first_name,last_name,count(r.rental_id) as no_of_rentals, sum(amount) as total_amount from customer c
join
rental r on c.customer_id=r.customer_id
join
payment p
on r.rental_id=p.rental_id
group by first_name, last_name
order by total_amount desc;

    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

SELECT 
  'investor' AS type, 
  first_name, 
  last_name, 
  company_name   
FROM 
  investor

UNION

SELECT 
  'advisor' AS type, 
  first_name, 
  last_name, 
  NULL AS company_name  -- Adding NULL as a placeholder
FROM 
  advisor;



/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/




SELECT
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END AS number_of_awards, 
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
	
FROM actor_award
	

GROUP BY 
	number_of_awards;


