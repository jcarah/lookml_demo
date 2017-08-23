view: dates {
  derived_table: {
    sql: select date_add('2016-01-01 00:00:00' , interval 1*id day) as day
          from orders
          where id <= 730
          group by 1
    ;;
  }

  dimension_group: day {
    type:time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.day ;;
  }
}
