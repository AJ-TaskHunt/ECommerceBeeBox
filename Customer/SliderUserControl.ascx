<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SliderUserControl.ascx.cs" Inherits="ECommerceBeeBox.Customer.SliderUserControl" %>


  <div id="image-slider" class="carousel slide pt-5" data-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="../CustomerTemplate/images/lego-fortnite-2024-games-1920x1080-13641.jpg" class="d-block w-100" alt="Slide 1">
           <%-- <div class="carousel-caption d-none d-md-block">
                <h5>Caption for Slide 1</h5>
                <p>Some description about Slide 1.</p>
                <a href="#" class="btn btn-primary">Learn More</a>
            </div>--%>
        </div>
        <div class="carousel-item">
            <img src="../CustomerTemplate/images/grand-theft-auto-vi-1920x1080-13975.png" class="d-block w-100" alt="Slide 2">
            <%--<div class="carousel-caption d-none d-md-block">
                <h5>Caption for Slide 2</h5>
                <p>Some description about Slide 2.</p>
                <a href="#" class="btn btn-primary">Learn More</a>
            </div>--%>
        </div>
        <div class="carousel-item">
            <img src="../CustomerTemplate/images/god-of-war-valhalla-1920x1080-13667.jpg" class="d-block w-100" alt="Slide 3">
           <%-- <div class="carousel-caption d-none d-md-block">
                <h5>Caption for Slide 3</h5>
                <p>Some description about Slide 3.</p>
                <a href="#" class="btn btn-primary">Learn More</a>
            </div>--%>
        </div>
    </div>
    <a class="carousel-control-prev" href="#image-slider" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#image-slider" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

