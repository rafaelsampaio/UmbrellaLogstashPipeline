def register(params)

end

def filter(event)
    require "time"
    require "tzinfo"

    timezone_name = "America/Sao_Paulo"
    timezone = TZInfo::Timezone.get(timezone_name)
    offset = timezone.current_period.observed_utc_offset

    utc_timestamp = Time.parse(event.get("[@timestamp]").to_s)
    local_timestamp = utc_timestamp.getlocal(offset)

    event.set("[custom][timestamp][weekday]", local_timestamp.strftime("%w").to_i+1)
    event.set("[custom][timestamp][month]", local_timestamp.strftime("%m").to_i)
    event.set("[custom][timestamp][day]", local_timestamp.strftime("%d").to_i)
    event.set("[custom][timestamp][hour]", local_timestamp.strftime("%H").to_i)
    event.set("[custom][timestamp][minute]", local_timestamp.strftime("%M").to_i)
    event.set("[custom][timestamp][week_number]", local_timestamp.strftime("%U").to_i)
    event.set("[custom][timestamp][timezone]", local_timestamp.strftime("%z"))

    return [event]
end
