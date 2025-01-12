component {

    public query function birthdays(required any group_id){

        query_result = queryExecute(
            "select p.id, p.first_name, p.last_name, ifnull(p.date_of_birth, 0) as date_of_birth, 
                ifnull(p.known_name, p.first_name) as known_name, month(p.date_of_birth) as month_number
                from group_people as g
                inner join people as p
                on g.people_id = p.id
                where (g.group_id = #group_id#)
                and p.id not in (190)
            order by month(p.date_of_birth), day(p.date_of_birth);",
                [], { datasource = "people"});

            return query_result;
    }

    public query function group(required any group_id){
        query_result = queryExecute(
            "select id, name, description
            from groups
            where id = '#group_id#';",
            [], { datasource = "people"});

            return query_result;
    }
    
    public query function group_people(required any group_id){
        query_result = queryExecute(
            "select p.id as people_id, first_name, middle_names, last_name, 
            ifnull(p.known_name, p.first_name) as known_name, by_line,
            date_of_birth,
            g.mailing_label_name
          from people.group_people as g
        
          inner join people.people as p
          on p.id = g.people_id
        
          where g.group_id = #group_id#
          and p.date_of_death is null
          and g.deleted_at is null
        
          order by ifnull(p.known_name, p.first_name), last_name;",
        [], { datasource = "people"});

        return query_result;
    }

}