# SwiftUIToolset

SwiftUI elements and tools that can make life simpler

## Featured elements:
1.MultilineTextField  
2.ContentInputField  
3.SearchBar  
4.CacheableImage
5.RefreshableScrollView  

## Featured extensions:
1. View size calculator
2. View shaper with some custom shapes added (more in the future)  
3. Handy PrefenceKeys and ViewModificators (tracking scroll view movement, sticking to the top of the scroll view (e.g. stretching header image), calculating fixed coordinates position)

## MultilineTextField
MultilineTextField is a convenient representation of the TextEditor:  
- Dynamic resizable  
- Configurable limitation visible lines (no need to upgrade to iOS 16)  
- Supports custom and system fonts  
- Placeholder available   
- Configurable background and foreground colors  
- UIFonts and SwiftUI Fonts support  

## ContentTextField  
ContentInputField fully preconfigured TextField with specific UITextContentType:  
- Supports dozen of UITextContentType  
- Optional error handling   
- Show/hide password functionality  
- UIFonts and SwiftUI Fonts support  

## SearchBar  
SearchBar is just a fully customizable SwiftUI representation of default UISearchBar:  
- Configurable placeholder  
- Supports custom and system fonts  
- Configurable background and foreground colors  
- UIFonts and SwiftUI Fonts support   

## CacheableImage
CacheableImage is a convenient representation of AsyncImage (no need to update to iOS 15)
- Image loading by URL link
- Cache storage (no need to double download)
- Default and custom placeholders are supported  
- A lot of build-in clipShapes supported

## RefreshableScrollView  
RefreshableScrollView is a solution for refreshing Content in ScrollView (no need to use SwiftUI Lists)
- Custom SwiftUI refreshing indicator with rotating animation  
- Customizable vibration on refresh action   
