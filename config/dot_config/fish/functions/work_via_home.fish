function work_via_home --description "Use sshuttle to access vpn through ssh tunnel"
    sshuttle --dns --method=nat -r pat@192.168.42.42 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16
end
