view: user_facts {
  derived_table: {
    sql: select
          u.id user_id,
          u.created_at signup_date,
          count(*) lifetime_orders,
          sum(sale_price) lifetime_revenue,
          min(o.created_at) first_order_date,
          max(o.created_at) last_order_date
          from users u
          left join orders o
          on u.id = o.user_id
          join order_items i
          on o.id = i.order_id
          group by 1,2
          ;;
  }

####### Dimensions #######
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id;;
    primary_key: yes
  }

  dimension_group: signup_date {
    timeframes: [date,
                day_of_month,
                day_of_week,
                month,
                week,
                year]
    sql: ${TABLE}.signup_date ;;
    type: time
  }

  dimension_group: first_order_date {
    timeframes: [date,
                day_of_month,
                day_of_week,
                month,
                week,
                year]
    sql: ${TABLE}.first_order_date ;;
    type: time
  }

  dimension_group: last_order_date {
    timeframes: [date,
                day_of_month,
                day_of_week,
                month,
                week,
                year]
    sql: ${TABLE}.last_order_date ;;
    type: time
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

dimension: is_paying_customer {
  type: yesno
  sql:  ${lifetime_orders} > 0 ;;
}

dimension: user_type {
  type: string
  sql: case when ${lifetime_orders} = 0
          then 'never ordered'
        when ${lifetime_orders} = 1
          then 'one time buyer'
        else 'repeat buyer' end;;
}

dimension: days_since_last_order{
  type: number
  sql: round(datediff(now(),${last_order_date_date}) ;;
}

####### Measures #######

  measure:  avg_ltr{
    type: average
    sql: ${lifetime_revenue} ;;
  }

  measure:  avg_lto{
    type: average
    sql: ${lifetime_orders} ;;
  }

  measure: avg_days_since_last_order {
    type: average
    sql: ${days_since_last_order} ;;
  }


#   measure: count {
#     type:  count
#   }
# Do I Need this ^


  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: user_facts {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
