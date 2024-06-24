package com.shinhan.travelTogether.photo;

import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;

@Service
public class PhotoService {

	@Autowired
	@Qualifier("photoDAO")
	PhotoDAO photoDAO;
	
	private AmazonS3 s3Client;
	
	@Value("${s3.bucket}")
	private String bucket;
	
	@Value("${s3.accessKey}")
	private String accessKey;
	
	@Value("${s3.secretKey}")
	private String secretKey;
	
	@Value("${s3.region}")
	private String region;
	
	
	@PostConstruct
	public void setS3Client() {
        AWSCredentials credentials = new BasicAWSCredentials(this.accessKey, this.secretKey);

        s3Client = AmazonS3ClientBuilder.standard()
                .withCredentials(new AWSStaticCredentialsProvider(credentials))
                .withRegion(this.region)
                .build();
	}
	
    public String upload(MultipartFile file, String detailPath) throws IOException {
		long time = System.currentTimeMillis();
		String originFileName = file.getOriginalFilename(); //
		String saveFileName = String.format("%d_%s", time, originFileName);

		String detailBucket = this.bucket + detailPath;
		
        s3Client.putObject(new PutObjectRequest(detailBucket, saveFileName, file.getInputStream(), null)
                .withCannedAcl(CannedAccessControlList.PublicRead));
        return s3Client.getUrl(bucket, saveFileName).toString();
    }
	
	
	
	
	public int insertPhoto(PhotoDTO photo) {
		return photoDAO.insertPhoto(photo);
	}
	
	public List<String> selectUserPhoto(int funding_id) {
		return photoDAO.selectUserPhoto(funding_id);
	}
	
	
}
