/queue type
set 0 pfifo-limit=500
set 4 kind=pcq pcq-classifier=dst-address
add kind=pcq name=TEST_Down pcq-classifier=dst-address pcq-rate=5M
add kind=pcq name=TEST_Up pcq-classifier=src-address pcq-rate=2M
/queue simple
add name="PRUEBAS DE VELOCIDAD" packet-marks=MIKRO-bypassed_f,MIKRO-bypassed_fast_Down,MIKRO-bypassed_fast_Up queue=TEST_Up/TEST_Down \
    target=192.168.0.0/16
/queue tree
add limit-at=100M max-limit=100M name=QoS-SUBIDA parent=ether3 queue=pcq-upload-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" max-limit=100M name=******RESTO_Up****** \
    parent=QoS-SUBIDA priority=1 queue=pcq-upload-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" max-limit=100M name=\
    ******SOLOCIALES_Up****** parent=QoS-SUBIDA priority=1 queue=pcq-upload-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" max-limit=100M name=\
    ******STREAMING_Up****** parent=QoS-SUBIDA priority=1 queue=pcq-upload-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" max-limit=100M name=\
    ******TRAFICO_Up****** parent=QoS-SUBIDA priority=1 queue=pcq-upload-default
add max-limit=100M name=PORNO_Up packet-mark=porno_f parent=******STREAMING_Up****** priority=7 queue=pcq-upload-default
add max-limit=100M name=UPDATE_WINDOWS_Up packet-mark=updateWindows_f parent=******RESTO_Up****** queue=pcq-upload-default
add max-limit=100M name=DNS_Up packet-mark=dns_f parent=******TRAFICO_Up****** priority=2 queue=pcq-upload-default
add max-limit=100M name=HTTP+HTTPS_Up packet-mark=http+https_f parent=******TRAFICO_Up****** priority=6 queue=pcq-upload-default
add max-limit=100M name=ICMP_Up packet-mark=icmp_f parent=******TRAFICO_Up****** priority=1 queue=pcq-upload-default
add max-limit=100M name=YOUTUBE_Up packet-mark=youtube_f parent=******STREAMING_Up****** priority=5 queue=pcq-upload-default
add max-limit=100M name=FACEBOOK_Up packet-mark=facebook_f parent=******SOLOCIALES_Up****** priority=4 queue=pcq-upload-default
add max-limit=100M name=INSTAGRAM_Up packet-mark=instagram_f parent=******SOLOCIALES_Up****** priority=3 queue=pcq-upload-default
add max-limit=100M name=NETFLIX_Up packet-mark=netflix_f parent=******STREAMING_Up****** priority=6 queue=pcq-upload-default
add max-limit=100M name=TWITTER_Up packet-mark=twitter_f parent=******SOLOCIALES_Up****** priority=3 queue=pcq-upload-default
add max-limit=100M name=WHATSAPP_Up packet-mark=whatsapp_f parent=******SOLOCIALES_Up****** priority=1 queue=pcq-upload-default
add max-limit=100M name=PRUEBAS_DE_VELOCIDAD_Up packet-mark=MIKRO-bypassed_f,MIKRO-bypassed_fast_Up parent=******RESTO_Up****** queue=\
    pcq-upload-default
add max-limit=100M name=CLASES_VIRTUALES_Up packet-mark=clases_virtuales_f parent=******SOLOCIALES_Up****** priority=1 queue=pcq-upload-default
add name=OTROS_Up packet-mark=otros_f parent=******RESTO_Up****** queue=pcq-upload-default
add limit-at=100M max-limit=100M name=QoS-BAJADA parent=global queue=pcq-download-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" limit-at=25M max-limit=100M name=\
    ******SOLOCIALES_Down****** parent=QoS-BAJADA priority=1 queue=pcq-download-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" limit-at=25M max-limit=100M name=\
    ******STREAMING_Down****** parent=QoS-BAJADA priority=1 queue=pcq-download-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" limit-at=25M max-limit=100M name=\
    ******TRAFICO_Down****** parent=QoS-BAJADA priority=1 queue=pcq-download-default
add comment="*************************************************************************************************************************************************\
    **************************************************************************************************************" limit-at=25M max-limit=100M name=\
    ******RESTO_Down****** parent=QoS-BAJADA priority=1 queue=pcq-download-default
add max-limit=100M name=PORNO_Down packet-mark=porno_f parent=******STREAMING_Down****** priority=7 queue=pcq-download-default
add max-limit=100M name=UPDATE_WINDOWS_Down packet-mark=updateWindows_f parent=******RESTO_Down****** queue=pcq-download-default
add max-limit=100M name=ICMP_Down packet-mark=icmp_f parent=******TRAFICO_Down****** priority=1 queue=pcq-download-default
add max-limit=100M name=DNS_Down packet-mark=dns_f parent=******TRAFICO_Down****** priority=2 queue=pcq-download-default
add max-limit=100M name=HTTP+HTTPS_Down packet-mark=http+https_f parent=******TRAFICO_Down****** priority=6 queue=pcq-download-default
add max-limit=100M name=YOUTUBE_Down packet-mark=youtube_f parent=******STREAMING_Down****** priority=5 queue=pcq-download-default
add max-limit=100M name=FACEBOOK_Down packet-mark=facebook_f parent=******SOLOCIALES_Down****** priority=4 queue=pcq-download-default
add max-limit=100M name=WHATSAPP_Down packet-mark=whatsapp_f parent=******SOLOCIALES_Down****** priority=1 queue=pcq-download-default
add max-limit=100M name=NETFLIX_Down packet-mark=netflix_f parent=******STREAMING_Down****** priority=6 queue=pcq-download-default
add max-limit=100M name=INSTAGRAM_Down packet-mark=instagram_f parent=******SOLOCIALES_Down****** priority=3 queue=pcq-download-default
add max-limit=100M name=TWITTER_Down packet-mark=twitter_f parent=******SOLOCIALES_Down****** priority=3 queue=pcq-download-default
add max-limit=100M name=PRUEBAS_DE_VELOCIDAD_Down packet-mark=MIKRO-bypassed_f,MIKRO-bypassed_fast_Down parent=******RESTO_Down****** queue=\
    pcq-download-default
add max-limit=100M name=CLASES_VIRTUALES_Down packet-mark=clases_virtuales_f parent=******SOLOCIALES_Down****** priority=1 queue=pcq-download-default
add name=OTROS_Down packet-mark=otros_f parent=******RESTO_Down****** queue=pcq-download-default


/ip firewall mangle
add action=mark-connection chain=prerouting comment="**********ICMP*******************************************************************************************\
    **********************************************************************************************************************************************************\
    ****************" new-connection-mark=icmp_Conn passthrough=yes protocol=icmp
add action=mark-packet chain=prerouting connection-mark=icmp_Conn new-packet-mark=icmp_f passthrough=no
add action=mark-connection chain=prerouting comment="**********DNS********************************************************************************************\
    **********************************************************************************************************************************************************\
    ****************" dst-port=53 new-connection-mark=dns_Conn passthrough=yes protocol=udp
add action=mark-packet chain=prerouting connection-mark=dns_Conn new-packet-mark=dns_f passthrough=no
add action=mark-connection chain=prerouting comment="**********YOUTUBE****************************************************************************************\
    **********************************************************************************************************************************************************\
    ************" dst-address-list=Youtube new-connection-mark=youtube_Conn passthrough=yes
add action=mark-packet chain=prerouting connection-mark=youtube_Conn new-packet-mark=youtube_f passthrough=no
add action=mark-connection chain=prerouting comment="**********FACEBOOK***************************************************************************************\
    **********************************************************************************************************************************************************\
    *************" dst-address-list=Facebook new-connection-mark=facebook_Conn passthrough=yes
add action=mark-packet chain=prerouting connection-mark=facebook_Conn new-packet-mark=facebook_f passthrough=no
add action=mark-connection chain=prerouting comment="**********PORNO******************************************************************************************\
    **********************************************************************************************************************************************************\
    **************" dst-address-list=Porno new-connection-mark=porno_Conn passthrough=yes
add action=mark-packet chain=prerouting connection-mark=porno_Conn new-packet-mark=porno_f passthrough=no
add action=mark-connection chain=prerouting comment="**********NETFLIX****************************************************************************************\
    **********************************************************************************************************************************************************\
    ***************" dst-address-list=Netflix new-connection-mark=netflix_Conn passthrough=yes src-address-list=!fast.com
add action=mark-packet chain=prerouting connection-mark=netflix_Conn new-packet-mark=netflix_f passthrough=no
add action=mark-connection chain=prerouting comment="**********WHATSAPP***************************************************************************************\
    **********************************************************************************************************************************************************\
    ***********" dst-address-list=Whatsapp new-connection-mark=whatsapp_Conn passthrough=yes
add action=mark-packet chain=prerouting connection-mark=whatsapp_Conn new-packet-mark=whatsapp_f passthrough=no
add action=mark-connection chain=prerouting comment="**********INSTAGRAM**************************************************************************************\
    **********************************************************************************************************************************************************\
    ***********" dst-address-list=Instagram new-connection-mark=instagram passthrough=yes
add action=mark-packet chain=prerouting connection-mark=instagram new-packet-mark=instagram_f passthrough=no
add action=mark-connection chain=prerouting comment="**********TWITTER****************************************************************************************\
    **********************************************************************************************************************************************************\
    *************" dst-address-list=Twitter new-connection-mark=twitter_Conn passthrough=yes
add action=mark-packet chain=prerouting connection-mark=twitter_Conn new-packet-mark=twitter_f passthrough=no
add action=mark-connection chain=prerouting comment="**********UPDATE WINDOWS*********************************************************************************\
    **********************************************************************************************************************************************************\
    ******" dst-address-list=UpdateWindows new-connection-mark=updateWindows_Conn passthrough=yes
add action=mark-packet chain=prerouting connection-mark=updateWindows_Conn new-packet-mark=updateWindows_f passthrough=no
add action=mark-connection chain=prerouting comment="**********PRUEBAS DE VELOCIDAD***************************************************************************\
    **********************************************************************************************************************************************************\
    ******" dst-port=8080,5060 new-connection-mark=MIKRO-bypassed passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting dst-port=8080,5060 new-connection-mark=MIKRO-bypassed passthrough=yes protocol=udp
add action=mark-connection chain=prerouting dst-port=80,443 new-connection-mark=MIKRO-bypassed passthrough=yes protocol=tcp tls-host=*.speedtest.net
add action=mark-connection chain=prerouting content=cdnst dst-port=80,443 new-connection-mark=MIKRO-bypassed passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting content=ookla dst-port=80,443 new-connection-mark=MIKRO-bypassed passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting content=nperf new-connection-mark=MIKRO-bypassed passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting dst-port=80,443 new-connection-mark=MIKRO-bypassed passthrough=yes protocol=tcp tls-host=\
    *.testdevelocidad.*
add action=mark-connection chain=prerouting content=testdevelocidad.es new-connection-mark=MIKRO-bypassed passthrough=yes protocol=tcp
add action=mark-packet chain=forward dst-address-list=fast.com new-packet-mark=MIKRO-bypassed_fast_Down passthrough=no protocol=tcp src-address-list=\
    Netflix
add action=mark-packet chain=forward dst-address-list=Netflix new-packet-mark=MIKRO-bypassed_fast_Up passthrough=yes protocol=tcp src-address-list=\
    fast.com
add action=mark-packet chain=prerouting connection-mark=MIKRO-bypassed new-packet-mark=MIKRO-bypassed_f passthrough=no
add action=mark-connection chain=prerouting comment="**********CLASES VIRTUALES*******************************************************************************\
    **********************************************************************************************************************************************************\
    *********" dst-port=3478-3481 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=50000-60000 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=1000-10000 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=50000-65000 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=16000-26000 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=19302-19309 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=8801,8802 new-connection-mark=clases_virtuales_Conn protocol=tcp
add action=mark-connection chain=prerouting dst-port=3478,3479,8801,8802 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=6463 new-connection-mark=clases_virtuales_Conn protocol=tcp
add action=mark-connection chain=prerouting dst-port=6457-6463 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-connection chain=prerouting dst-port=53,80,5223,16393-16472 new-connection-mark=clases_virtuales_Conn protocol=udp
add action=mark-packet chain=prerouting connection-mark=clases_virtuales_Conn new-packet-mark=clases_virtuales_f passthrough=no
add action=mark-connection chain=prerouting comment="**********HTTP+HTTPS*************************************************************************************\
    **********************************************************************************************************************************************************\
    ***********" dst-port=80,443 new-connection-mark=http+https_Conn passthrough=yes protocol=tcp
add action=mark-packet chain=prerouting connection-mark=http+https_Conn new-packet-mark=http+https_f passthrough=no
add action=mark-connection chain=prerouting comment="**********OTROS******************************************************************************************\
    **********************************************************************************************************************************************************\
    **************" new-connection-mark=otros_Conn passthrough=yes
add action=mark-packet chain=prerouting connection-mark=otros_Conn new-packet-mark=otros_f passthrough=no

/ip firewall raw
add action=add-dst-to-address-list address-list=Youtube address-list-timeout=1d chain=prerouting comment="**********YOUTUBE***********************************\
    **********************************************************************************************************************************************************\
    *****************************************************************" content=googlevideo dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Youtube address-list-timeout=1d chain=prerouting content=www.youtube.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Youtube address-list-timeout=1d chain=prerouting content=youtube.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Youtube address-list-timeout=1d chain=prerouting content=m.youtube.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Youtube address-list-timeout=1d chain=prerouting content=youtu.be dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Youtube address-list-timeout=1d chain=prerouting content=ytimg dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Facebook address-list-timeout=1d chain=prerouting comment="**********FACEBOOK*********************************\
    **********************************************************************************************************************************************************\
    *******************************************************************" content=facebook.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Facebook address-list-timeout=1d chain=prerouting content=api.facebook.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Facebook address-list-timeout=1d chain=prerouting content=fbcdn.net dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Facebook address-list-timeout=1d chain=prerouting content=fbsbx.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Facebook address-list-timeout=1d chain=prerouting content=www.facebook.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Facebook address-list-timeout=1d chain=prerouting content=m.facebook.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Netflix address-list-timeout=1d chain=prerouting comment="**********NETFLIX***********************************\
    **********************************************************************************************************************************************************\
    ********************************************************************" content=netflix.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Netflix address-list-timeout=1d chain=prerouting content=nflxvideo.net dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Netflix address-list-timeout=1d chain=prerouting content=nflxso.net dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Netflix address-list-timeout=1d chain=prerouting content=api.fast.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting comment="**********PORNO***************************************\
    **********************************************************************************************************************************************************\
    *****************************************************************" content=egc.xnxx-cdn.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=xnxx.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=brazzer dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=xvideos-cdn.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=xvideos.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=serviporno.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=videospornogratisx.net dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=youporn.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=ypncdn.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=toroporno.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Porno address-list-timeout=1d chain=prerouting content=es.pornhub.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Whatsapp address-list-timeout=1d chain=prerouting comment="**********WHATSAPP*********************************\
    **********************************************************************************************************************************************************\
    *****************************************************************" content=whatsapp.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Whatsapp address-list-timeout=1d chain=prerouting content=www.whatsapp.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Whatsapp address-list-timeout=1d chain=prerouting content=web.whatsapp.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Whatsapp address-list-timeout=1d chain=prerouting content=whatsapp.net dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Instagram address-list-timeout=1d chain=prerouting comment="**********INSTAGRAM*******************************\
    **********************************************************************************************************************************************************\
    ******************************************************************" content=instagram.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Instagram address-list-timeout=1d chain=prerouting content=mobile.instagram.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Instagram address-list-timeout=1d chain=prerouting content=www.instagram.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Twitter address-list-timeout=1d chain=prerouting comment="**********TWITTER***********************************\
    **********************************************************************************************************************************************************\
    ******************************************************************" content=twitter.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Twitter address-list-timeout=1d chain=prerouting content=mobile.twitter.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=Twitter address-list-timeout=1d chain=prerouting content=s.twitter.com dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting comment="**********UPDATE WINDOWS**********************\
    **********************************************************************************************************************************************************\
    *****************************************************************" content=windowsupdate dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting content=msedge dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting content=azureedge dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting content=update.microsoft dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting content=download.microsoft dst-port=80,443 protocol=\
    tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting content=msecnd dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting content=edgecast dst-port=80,443 protocol=tcp
add action=add-dst-to-address-list address-list=UpdateWindows address-list-timeout=1d chain=prerouting content=alphacdn dst-port=80,443 protocol=tcp
add action=add-src-to-address-list address-list=fast.com address-list-timeout=30s chain=prerouting comment=**********FAST.COM********** content=fast.com \
    dst-port=80,443 protocol=tcp