from pyspark import SparkContextfrom pyspark.sql import HiveContextsc = SparkContext(appName="HiveQuery")
hive_context = HiveContext(sc)
call_center = hive_context.table("tpcds_text_30.call_center")
catalog_page = hive_context.table("tpcds_text_30.catalog_page")
catalog_returns = hive_context.table("tpcds_text_30.catalog_returns")
catalog_sales = hive_context.table("tpcds_text_30.catalog_sales")
customer = hive_context.table("tpcds_text_30.customer")
customer_address = hive_context.table("tpcds_text_30.customer_address")
customer_demographics = hive_context.table("tpcds_text_30.customer_demographics")
date_dim = hive_context.table("tpcds_text_30.date_dim")
household_demographics = hive_context.table("tpcds_text_30.household_demographics")
income_band = hive_context.table("tpcds_text_30.income_band")
inventory = hive_context.table("tpcds_text_30.inventory")
item = hive_context.table("tpcds_text_30.item")
promotion = hive_context.table("tpcds_text_30.promotion")
reason = hive_context.table("tpcds_text_30.reason")
ship_mode = hive_context.table("tpcds_text_30.ship_mode")
store = hive_context.table("tpcds_text_30.store")
store_returns = hive_context.table("tpcds_text_30.store_returns")
time_dim = hive_context.table("tpcds_text_30.time_dim")
warehouse = hive_context.table("tpcds_text_30.warehouse")
web_page = hive_context.table("tpcds_text_30.web_page")
web_returns = hive_context.table("tpcds_text_30.web_returns")
web_sales = hive_context.table("tpcds_text_30.web_sales")
web_site = hive_context.table("tpcds_text_30.web_site")
store_sales = hive_context.table("tpcds_text_30.store_sales")
call_center.registerTempTable("call_center")
catalog_page.registerTempTable("catalog_page")
catalog_returns.registerTempTable("catalog_returns")
catalog_sales.registerTempTable("catalog_sales")
customer.registerTempTable("customer")
customer_address.registerTempTable("customer_address")
customer_demographics.registerTempTable("customer_demographics")
date_dim.registerTempTable("date_dim")
household_demographics.registerTempTable("household_demographics")
income_band.registerTempTable("income_band")
inventory.registerTempTable("inventory")
item.registerTempTable("item")
promotion.registerTempTable("promotion")
reason.registerTempTable("reason")
ship_mode.registerTempTable("ship_mode")
store.registerTempTable("store")
store_returns.registerTempTable("store_returns")
time_dim.registerTempTable("time_dim")
warehouse.registerTempTable("warehouse")
web_page.registerTempTable("web_page")
web_returns.registerTempTable("web_returns")
web_sales.registerTempTable("web_sales")
web_site.registerTempTable("web_site")
store_sales.registerTempTable("store_sales")