select channelGrouping,
-- create array data
ARRAY_AGG(STRUCT(totals_transactions, geoNetwork_country, date) ORDER BY geoNetwork_country, date)
from 
(select channelGrouping, sum(totals_transactions) as totals_transactions, date, geoNetwork_country 
from `data-to-insights.ecommerce.rev_transactions`
-- cleaning data where country is not set
where geoNetwork_country not in ('(not set)')
group by channelGrouping, date, geoNetwork_country)
-- grouping by channelGrouping
group by channelGrouping