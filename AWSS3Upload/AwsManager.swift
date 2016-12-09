//
//  AwsManager.swift
//  AWSS3Upload
//
//  Created by Raghvendra on 08/12/16.
//  Copyright © 2016 OneCorp. All rights reserved.
//

import Foundation

import AWSS3


func configAwsManager(poolId:String = "xxxxxxxxx",region:AWSRegionType = AWSRegionType.apNortheast1){

    
    // configure authentication with Cognito
    let CognitoPoolID = poolId
    let Region = region
    let credentialsProvider = AWSCognitoCredentialsProvider(regionType:Region,
                                                            identityPoolId:CognitoPoolID)
    
    let configuration = AWSServiceConfiguration(region:Region, credentialsProvider:credentialsProvider)
    
    AWSServiceManager.default().defaultServiceConfiguration = configuration
}

func sendFile(imageName:String,image:UIImage, extention:String,S3BucketName:String){
    let ext = extention
    let fileName = imageName + "." + ext
    let uploadRequest = AWSS3TransferManagerUploadRequest()
    do {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent(fileName)
        if let pngImageData = UIImageJPEGRepresentation(image, 0.1) {
            try pngImageData.write(to: fileURL, options: .atomic)
        }
        
        uploadRequest?.body = fileURL
        uploadRequest?.key = fileName
        uploadRequest?.bucket = S3BucketName
        //uploadRequest?.contentType = "image/" + ext
    } catch {
        print("failed")
    }
    
    // build an upload request
  
    
    // upload
    let transferManager = AWSS3TransferManager.default()
    transferManager?.upload(uploadRequest).continue({ (task) -> Any? in
        if let error = task.error {
            print("Upload failed ❌ (\(error))")
        }
        
        if let exception = task.exception {
            print("Upload failed ❌ (\(exception))")
        }
        
        if task.result != nil {
            let s3URL = NSURL(string: "http://s3.amazonaws.com/\(S3BucketName)/\(fileName)")!
            //let image = UIImage(data: NSData(contentsOf: s3URL as URL)! as Data)
            print("Uploaded to:\n\(s3URL)")
        }
        else {
            print("Unexpected empty result.")
        }
        return nil
        
    })
        //.continue { (task) -> AnyObject! in
    
    
    
}

//func getFile(S3BucketName:String,image:String){
//    let downloadingFileURL = URL(string: image)
//    
//        //NSURL(fileURLWithPath: image )
//    let transferManager = AWSS3TransferManager.default()
//    let readRequest1 : AWSS3TransferManagerDownloadRequest = AWSS3TransferManagerDownloadRequest()
//    readRequest1.bucket = "shrikar-picbucket"
//    readRequest1.key =  "bingo"
//    readRequest1.downloadingFileURL = downloadingFileURL as URL!
//    
//    let task = transferManager?.download(readRequest1)
//    task?.continue( { (task) -> Any in
//        print(task.error ?? <#default value#>)
//        if let error = task.error {
//            print("Upload failed ❌ (\(error))")
//        }
//        
//        if let exception = task.exception {
//            print("Upload failed ❌ (\(exception))")
//        }
//        if task.result != nil {
//            
//            print("Fetched image")
//        }
//        return nil
//    })
//}

