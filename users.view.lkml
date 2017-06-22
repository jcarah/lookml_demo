view: users {
  sql_table_name: demo_db.users ;;
  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type:  number
    sql: ${TABLE}.age ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql:  ${TABLE}.first_name ;;
  }

  dimension: last_name  {
    type: string
    sql:  ${TABLE}.last_name ;;
  }

  dimension: gender {
    type: string
    sql:  ${TABLE}.gender ;;
  }

  dimension_group: created {
    type: time
    timeframes: [date,
      day_of_month,
      day_of_week,
      day_of_week_index,
      day_of_year,
      hour_of_day,
      month,
      year]
    datatype: timestamp
    sql: ${TABLE}.created_at ;;
    }

  dimension: zip {
    type: zipcode
    sql:  ${TABLE}.zip ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.country;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city;;
  }

  dimension: age_tier{
    type: tier
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    style: interval
    sql: ${TABLE}.age;;
  }

  measure: count {
    type: count
    drill_fields: [user_details*]

  }

set: user_details {
  fields: [age,
    email,
    city,
    country,
    created_date,
    created_month,
    created_year,
    email,
    first_name,
    last_name,
    gender
    ]

    }

}































#   dimension: id {
#     primary_key: yes
#     type: number
#     sql: ${TABLE}.id ;;
#   }
#
#   dimension: age {
#     type: number
#     sql: ${TABLE}.age ;;
#   }
#
#   dimension: city {
#     type: string
#     sql: ${TABLE}.city ;;
#   }
#
#   dimension: country {
#     type: string
#     sql: ${TABLE}.country ;;
#   }
#
#   dimension_group: created {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.created_at ;;
#   }
#
#   dimension: email {
#     type: string
#     sql: ${TABLE}.email ;;
#   }
#
#   dimension: first_name {
#     type: string
#     sql: ${TABLE}.first_name ;;
#   }
#
#   dimension: gender {
#     type: string
#     sql: ${TABLE}.gender ;;
#   }
#
#   dimension: last_name {
#     type: string
#     sql: ${TABLE}.last_name ;;
#   }
#
#   dimension: state {
#     type: string
#     sql: ${TABLE}.state ;;
#   }
#
#   dimension: zip {
#     type: zipcode
#     sql: ${TABLE}.zip ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#
#   # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       id,
#       last_name,
#       first_name,
#       events.count,
#       orders.count,
#       user_data.count
#     ]
#   }
# }
