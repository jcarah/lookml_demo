view: returns {
  sql_table_name: demo_db.orders ;;
  dimension: id {
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: date_add(returns.created_at, interval 5 day) ;;
  }
  measure: count {
    type: count
  }
}
