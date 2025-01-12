component {

    public query function addresses(required any people_id){
        query_result = queryExecute(
            "    select p.people_id, p.address_id,
            a.address_1, a.address_2, a.address_3, a.city,
            a.region, a.postal_code, c.title as country
          from addresses as p
      
          inner join addresses.addresses as a
          on p.address_id = a.id
      
          left outer join addresses.country_codes as c
          on c.id = a.country_id
      
          where p.people_id = #people_id#
            and p.deleted_at is null
            and is_primary = 1;",
            [], { datasource = "people"});

        return query_result;
    }

    public query function email_addresses(required any people_id){
        query_result = queryExecute(
            "select e.email
            from people.email_addresses as e
            where e.people_id = #people_id#
            and e.primary = 1;",
        [], { datasource = "people"});

        return query_result;
    }

    public query function phone_numbers(required any people_id) {
        query_result = queryExecute(
            "select p.country_code, p.area_code, p.phone_number, t.phone_type
            from phone_numbers as p
            
            left outer join phone_types as t
            on p.phone_type_id = t.id
        
            where p.people_id = #people_id#
            and p.show = 1
            and p.deleted_at is null;",
        [], { datasource = "people"});

        return query_result;
    }

}