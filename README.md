# zylentrix_api_task

# Flutter API Fetching Assignment  

##  Overview  
This Flutter application fetches data from a public API and displays it in a **scrollable ListView**. 
It demonstrates API integration, error handling, loading indicators, and structured state management.  

##  Features  
- Fetches data from `https://jsonplaceholder.typicode.com/posts`.  
- Displays post titles grouped by `userId`.  Showing posts by userId rather than just titles and description for better user experience.
- Shows a **loading indicator** (`CircularProgressIndicator`) while fetching data.  
- Handles API errors gracefully and displays an error message if fetching fails.  
- Uses **MVVM architecture** with `ChangeNotifier`.  
- Clean and structured code with a **separate API service and ViewModel**.  
- Proper network error handling when offline


##  Technologies Used  
- **Flutter** (Latest version)  
- **Dart**  
- **http package** (for API calls)  `https://pub.dev/packages/http/install`
- **Provider** (for state management)  

##  Project Structure
zylentrix_api_task/
|──lib/|
|──main.dart #Entry point of the app|
├── models/ │ 
│ ├── post_model.dart # Post model for API data │ 
├── services/ │ 
│ ├── api_services.dart # API service for fetching data │ 
├── viewmodels/ │ 
│ ├── post_viewmodel.dart # ViewModel for managing API data │ 
├── views/ │ 
│ ├── post_list_screen.dart # UI to display API data 
│── pubspec.yaml # Dependencies & configuration


## Project Setup
### Clone the Repository**

git clone https://github.com/AdityaDarji/zylentrix_task.git
cd zylentrix_task