package com.ntu.igts.model;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonRootName;

@JsonRootName("cover")
public class Cover extends BaseModel implements Serializable {

    private static final long serialVersionUID = -1694684288090046696L;
    @JsonProperty("commodityid")
    private String commodityId;
    @JsonProperty("imageid")
    private String imageId;
    @JsonProperty("description")
    private String description;
    @JsonProperty("maincoveryn")
    private String mainCoverYN = "N";
    @JsonProperty("displaysequence")
    private int displaySequence;
    @JsonProperty("image")
    private Image image;

    public String getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(String commodityId) {
        this.commodityId = commodityId;
    }

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMainCoverYN() {
        return mainCoverYN;
    }

    public void setMainCoverYN(String mainCoverYN) {
        this.mainCoverYN = mainCoverYN;
    }

    public int getDisplaySequence() {
        return displaySequence;
    }

    public void setDisplaySequence(int displaySequence) {
        this.displaySequence = displaySequence;
    }

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

}
