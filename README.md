
KURULUM VE TEST ADIMLARI

1) Containerlab topolojisini ayağa kaldırma

Önce topology dosyasının bulunduğu dizine girin.

containerlab deploy -t myfabric01.clab.yml

Bu komut, Containerlab lab ortamını başlatır ve Ansible için inventory dosyasını otomatik oluşturur.

--------------------------------------------------

2) Ansible kurulumu

Sistemde Ansible yoksa aşağıdaki komutlarla kurulum yapın.

sudo apt update
sudo apt install ansible -y

Kurulumu kontrol etmek için:

ansible --version

--------------------------------------------------

3) Ansible inventory kontrolü

Containerlab tarafından üretilen inventory dosyasını kontrol edin.

ansible-inventory -i ansible-inventory.yml --graph

Bu komut spine, leaf ve diğer grupların doğru şekilde oluştuğunu gösterir.

--------------------------------------------------

4) İlk precheck playbook çalıştırma

Inventory ve grup yapısını doğrulamak için aşağıdaki playbook’u çalıştırın.

ansible-playbook playbooks/site.yml

Bu aşamada cihazlara bağlantı kurulmaz, sadece inventory bilgisi test edilir.

--------------------------------------------------

5) Gerekli Ansible collection’ların kurulumu

SR Linux cihazlarıyla API üzerinden çalışabilmek için gerekli collection’ları kurun.

ansible-galaxy collection install ansible.netcommon
ansible-galaxy collection install nokia.srlinux

Alternatif olarak requirements dosyası kullanılabilir.

requirements.yml içeriği:

collections:
  - name: ansible.netcommon
  - name: nokia.srlinux

Kurulum:

ansible-galaxy collection install -r requirements.yml --force

--------------------------------------------------

6) SR Linux HttpAPI plugin kontrolü

HttpAPI plugin’inin yüklü olduğunu doğrulamak için:

ansible-doc -t httpapi nokia.srlinux.srlinux

Bu komut çıktı veriyorsa plugin doğru şekilde kurulmuştur.

--------------------------------------------------

7) SR Linux API bağlantı testi

SR Linux cihazlardan sadece okuma (state) işlemi yapmak için test playbook’unu çalıştırın.

ansible-playbook playbooks/test_srl.yml -vv

Başarılı bir çalıştırmada her node için SR Linux versiyon bilgisi görüntülenir.

--------------------------------------------------

8) YANG path keşfi (discovery)

SR Linux konfigürasyon ve state ağaçlarını incelemek için discovery playbook’unu çalıştırın.

ansible-playbook playbooks/discover_system.yml -vv

Bu adım doğru config path’lerini öğrenmek için kullanılır.

--------------------------------------------------

NOTLAR

SR Linux otomasyonu CLI mantığıyla değil, model-driven (YANG tabanlı) çalışır.
update ve replace arasındaki fark önemlidir.
Leaf node’lar için çoğu zaman replace kullanılır.
Inventory dosyası Containerlab tarafından otomatik olarak üretilir.

--------------------------------------------------

SONRAKİ ADIMLAR

Hostname konfigürasyonu
Loopback interface ve IP adresi
Spine / Leaf role bazlı yapı
Verification ve assert kontrolleri
Underlay (ISIS / BGP) otomasyonu
