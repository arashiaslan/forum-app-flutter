<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\Feed\FeedController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('feeds', FeedController::class);
    Route::post('/like/{feed_id}', [FeedController::class, 'likePost']);
    Route::post('/comment/{feed_id}', [FeedController::class, 'comment']);
    Route::get('/comments/{feed_id}', [FeedController::class, 'getComments']);
    Route::post('/logout', [AuthController::class, 'logout']);
});