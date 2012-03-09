#!/usr/bin/bash

pingInterface ( ) {
        interface=$1
        if /usr/sbin/ping -c1 $interface 2 | grep alive
        then
                echo "foo" > /dev/null
                return 0
        else
                echo ""
                echo ":: WARNING: No response for IP Address: $interface ::"
                echo "Need to Check: Is this interface supposed to be up, or is it admin-down? "
                echo "LAN ports may be admin down during initial router installation."
                echo ""
                return 1
        fi
}

pingInterfaceToParse ( ) {
        interface=$1
        if /usr/sbin/ping -c1 $interface 2 | grep alive
        then
                echo "foo" > /dev/null
                return 0
        else
                echo "$interface is Not Alive"
                return 1
        fi
}


case $1 in
-f)
        INTERFACE_FILE=$2
        for i in `cat $INTERFACE_FILE`; do
                pingInterface $i
        done;  

        rm -f $INTERFACE_FILE
        exit 0
    ;;
-i) 
        pingInterface $2 
        exit $?
    ;;
-p)
        INTERFACE_FILE=$2
        for i in `cat $INTERFACE_FILE`; do
                pingInterfaceToParse $i
        done;  

        rm -f $INTERFACE_FILE
        exit 0
    ;;
*)
    echo "unknown option" >&2
    exit 2
    ;;
esac

exit

