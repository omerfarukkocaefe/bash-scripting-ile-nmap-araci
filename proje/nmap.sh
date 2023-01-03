# /bin/bash!

echo "==================================================="
yes | apt install nmap
echo "==================================================="

IP=$(zenity --forms --title="IP ekle" \
	--text="Hedef IP adresini giriniz." \
	--separator="," \
	--add-entry="IP"
	>> addr.csv)

touch nmap_tarama_sonucu.txt

while :
do 
	if [ $IP != -1 ]
	then
		tarama_cesidi=$(zenity --list \
			--title="NMAP TARAMA" \
		  	--column="Tarama Cesidi"\
		    	Ping_Tarama\
			Basit_Tarama\
			Versiyon_Bilgisi_Tarama\
			Agresif_Tarama\
			Tum_Portlari_Tarama)
		
		if [ $tarama_cesidi == Ping_Tarama ]
		then
			# cat "===================================================" > nmap_tarama_sonucu.txt	
			Subnet=$(zenity	--forms --title="Subnet ekle" \
					--text="Hedef Subnet adresini giriniz (ornek 192.168.1.0/24)." \
					--separator="," \
					--add-entry="Subnet")
		
			nmap -sP $Subnet > nmap_tarama_sonucu.txt &
		
		elif [ $tarama_cesidi == Basit_Tarama ]
		then
			nmap $IP > nmap_tarama_sonucu.txt &
	
		elif [ $tarama_cesidi == Versiyon_Bilgisi_Tarama ]
		then
	
			nmap -sV $IP > nmap_tarama_sonucu.txt &
		elif [ $tarama_cesidi == Agresif_Tarama ]
		then
			nmap -A $IP > nmap_tarama_sonucu.txt &
	
		elif [ $tarama_cesidi == Tum_Portlari_Tarama ]
		then
			nmap -p- $IP > nmap_tarama_sonucu.txt &
	
		else
			zenity 	--info\
				--text= "Yanlis secim yaptiniz!"
		fi
	
		if [ $tarama_cesidi != -1 ]
		then
			(
			echo "0" ; sleep 2
			echo "# NMAP taramayi gerceklestiriyor..." ; sleep 1
			echo "25" ; sleep 2
			echo "# NMAP taramayi gerceklestiriyor..." ; sleep 1
			echo "50" ; sleep 2
			echo "# NMAP taramayi gerceklestiriyor..." ; sleep 1
			echo "75" ; sleep 2
			echo "# NMAP taramasi bitti!" ; sleep 1
			echo "100" ; sleep 2
			) |
			zenity --progress \
	  			--title="NMAP Taramayi gerceklestiriyor" \
	  			--text="NMAP taramasi bitti!" \
	  			--percentage=0
			
			zenity 	--info\
				--text="Nmap tarama sonucu, bulundugunuz dizinde bulunan \" nmap_tarama_sonucu.txt\" dosyasina yazilmistir."
			
			secim=$(zenity --forms --title="Secim Yap" \
				--text="Devam etmek icin \"devam\" giriniz." \
				--separator="," \
				--add-entry="Secenek")
			
			if [ $secim == "devam" ]
			then
				continue
			else
				break
			fi
		else
			zenity 	--info\
				--text="Cikis isleminiz alinmistir. Iyi gunler dileriz..."
			break
		fi
	else
		break
	fi
done


