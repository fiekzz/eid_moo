# EidMoo - An app to reserve Qurban cow portions for Eid Adha

## Team krvpton
### FIKRI BIN HISHAM-MUDDIN 2112011

## Description of the project
### Introduction
This app simplifies the process of reserving portions of a cow for Qurban during Eid al-Adha. Users can browse available portions, make reservations, and coordinate with their local surau, which oversees the Qurban process. The app helps manage and track reservations, ensuring an organized and accessible experience for participating in this important Islamic ritual.
### Objective
The objective of the app is to streamline and simplify the process of reserving and managing portions of a cow for Qurban, ensuring efficient coordination with local suraus and providing a seamless and organized experience for users participating in the Eid al-Adha sacrifice.
### Features and Functionalities:
1. Authorization : Authorizing User or Admin. 
2. User Profiles : Detail information and history of booking .
3. Detail System : Detail information of the list of cow and portion available.
4. Payment System : User need to fill borang akad and show the proof of payment.
5. Approved System : Show the name and detail information of buyer for admin to check and approved.

## Project Structure
### UI and Reusable Widgets
1. Authorization screen : login form
2. Profile Screen : User information and history of booking.
3. Detail Screen : Cow information. 
4. Payment Screen : akad form and fill receipt payment.
5. Admin Screen : Buyer Information and Approved function.

### Stacks used
1. Flutter
3. Firebase (authentication)
4. Local-auth (Biometric login)
5. MobileScanner (QR Scanner)
6. HonoJS (Backend Server https://eidmoo-backend.fiekzz.com)
7. Postgresql (SQL Database)
8. Nginx (Reverse proxy server)
9. Prisma (Object related mapping)

### Navigation Diagram
<img width="1138" alt="eid-moo" src="https://github.com/lqmanalhakim/eid_moo/assets/75507209/bddd50cd-7645-4435-af7c-1bcfb72051b7">

### Sequence Diagram
![Sequence Diagram drawio](https://github.com/lqmanalhakim/eid_moo/assets/133849888/b91195b0-695e-4c74-b3a1-e1cd6808b13e)

### Database Schema
![Database](https://github.com/fiekzz/eid_moo/assets/75507209/f80eede5-7ff0-459b-866b-146b2270d4e3)


### Project Screenshots
[Eidmoo](https://drive.google.com/drive/folders/1iV3-mx8p-ALE1UeWEbSjI4W0aQB6bkS7?usp=sharing)

### Project Schedule
Total day(s) spent: 16 Hours

9 June 2024
1. Project kickoff (Initial commit from original repository)

11 June 2024
1. Add some basic screens
2. Remove unwanted platforms
3. Update configurations for Apple (IOS)

26 June 2024
1. Add new components
2. Authentication pages
3. Logo update
4. Firebase auth integrations
5. New dependencies (riverpod and securestorage)
6. New bash scripts (IOS fix script and dependencies pub get)

27 June 2024
1. Add launcher icon
2. Major updates (new screens) [accounts, auth, booking, general, masjid]
3. Implemented crucial technology [biometric login such as Face Id and Fingerprint, qr generator, qr scanner]

### References
1. Borang Pendaftaran Korban. Kembara Korban 1001 Asnaf Sdn Bhd. (n.d.). https://daftar.ybim.org.my/v2/SSN
2. Rostin, S. (2023, May 18). Lafaz NIAT Korban Lembu Dalam Rumi. Blog EZ Qurban. https://blog.ezqurban.org/lafaz-niat-korban-lembu-dalam-rumi/
Google. (n.d.).
3. Borang Akad Korban 1434h.PDF. Google Drive. https://docs.google.com/file/d/0ByKX82NSbnR2enVLSzNRVG5kUW8/edit?pli=1&resourcekey=0-JbdH88OPqMm357KXNn7RcA
4. Debasish Das (2023, May 10) Flutter Biometric Auth Integration: A Comprehensive Guide to Implementing Secure Mobile Authentication. https://medium.com/@debasishkumardas5/secure-your-flutter-app-with-biometric-authentication-integration-b1efa9b1b9e2
5. [Developers](https://www.scandit.com/blog/category/developers/) (2024, April 16) A Flutter Developer’s Guide to Barcode & QR Code Scanning. https://www.scandit.com/blog/flutter-developers-guide-barcode-qr-code-scanning/
