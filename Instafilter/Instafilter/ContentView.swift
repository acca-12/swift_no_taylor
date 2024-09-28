//
//  ContentView.swift
//  Instafilter
//
//  Created by Alfonso Acosta on 2024-09-24.
//

import SwiftUI
import PhotosUI //for photopicker
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit //app store


struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem? //core image allows us to pick
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    //without the conformity, it was saying that our CIFilter was conforming to the CISepiaTone, by adding this we can adjust our filters!
    let context = CIContext() //context is reponsible for loading CIImage to a CGImage (pixels we can actually work with), expensive to create so good idea to create context once and keep it alive
    
    @State private var showingFilters = false
    @AppStorage("filterCount") var filterCount = 0 //keeps track of how many times the user has changed the filter
    @Environment(\.requestReview) var requestReview
    func changeFilter(){
        showingFilters = true
    }
    
    func applyProcessing(){
        // this breaks currentFilter.intensity = Float(filterIntensity)
        //this now works for all thing conforming
        // some filters don't have the intensity key currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
    
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
                
        
    }
    
    func loadImage(){
        //Recall that taska llows us to start asynch work as soon as the view is shown
        Task{
            //recall that we cant exactly load a simple swift ui image because it can't be fed into Core Image, so instead we load a pure data object and convert it to UII
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            //Much safer to user filter's setvalue with kCIInputImageKey than dedicated ci filter inputImageProperty
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()

        }
    }
    
    @MainActor func setFilter(_ filter: CIFilter){ //MainActor is the part of our app that's able to work with UI. throws error without it becuse swift can't guarantee this code will run on the main actor unless we specify it
        currentFilter = filter
        loadImage() //means that image loading is triggered everytime a filter changes
        //can make this a little faster by sotring beginImage in another @State to avoid reloading the image each time a filter changes
        filterCount += 1

        if filterCount == 5 {
            requestReview()
        } //ask to leave a review
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                PhotosPicker(selection: $selectedItem){
                    if let processedImage{
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.bade.plus", description: Text("Tap to import a photo"))
                    }
                }.onChange(of: selectedItem, loadImage) //runs function whenever selectedItem property changes
                //wihtout the onChange on the slider, it only applies the filter when we load the image
                Spacer()
                
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change Filter", action: changeFilter)
                        
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters){
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

#Preview {
    ContentView()
}
