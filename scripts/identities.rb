def register(params)

end

def filter(event)
    identities = event.get("[Identities]").split(",")
    identity_types = event.get("[IdentityTypes]").split(",")
    identity = Hash.new

    identity_types.each { |t|
        identity.store(t.gsub(" ", "_").downcase, Array.new)
    }
    #types: AD Computers, AD Users, Sites, Internal Networks, Networks, Network Devices
    identity_types.each_with_index { |t, i|
        identity[t.gsub(" ", "_").downcase].push(identities[i])
    }

    if identity.key?("ad_computers")
        event.set("[host][name]", identity["ad_computers"])
        event.set("[host][hostname]", identity["ad_computers"])
    end

    if identity.key?("ad_users")
        event.set("[source][user][name]", identity["ad_users"])
    end

    if identity.key?("sites")
        event.set("[network][site_name]", identity["sites"])
    end

    if identity.key?("internal_networks")
        event.set("[network][internal_name]", identity["internal_networks"])
    end

    if identity.key?("networks")
        event.set("[network][name]", identity["networks"])
    end

    if identity.key?("network_devices")
        event.set("[network][device_name]", identity["network_devices"])
    end

    return [event]
end
